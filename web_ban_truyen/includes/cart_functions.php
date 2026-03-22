<?php
// Cart helper functions (session + cookie) for the shop.
// Provides basic cart management and flash messaging.

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Cookie settings (base name, actual cookie key sẽ phụ thuộc tài khoản)
if (!defined('CART_COOKIE_NAME')) {
    define('CART_COOKIE_NAME', 'shop_cart');
}
if (!defined('CART_COOKIE_TTL')) {
    define('CART_COOKIE_TTL', 86400 * 7);
}

/**
 * Tạo key giỏ hàng theo tài khoản (user_X) hoặc khách (guest_sessionid)
 *
 * @return string
 */
function getCartKey(): string
{
    if (session_status() === PHP_SESSION_NONE) {
        session_start();
    }

    if (!empty($_SESSION['user']) && isset($_SESSION['user']['ma_tk'])) {
        return 'user_' . (int)$_SESSION['user']['ma_tk'];
    }

    return 'guest_' . session_id();
}

/**
 * Tên cookie thật sự dùng để lưu giỏ hàng (theo từng tài khoản/khách)
 *
 * @return string
 */
function getCartCookieName(): string
{
    // Vẫn giữ CART_COOKIE_NAME để tương thích, nhưng thêm hậu tố theo key giỏ hàng
    return CART_COOKIE_NAME . '_' . getCartKey();
}

/**
 * Get the cart from session (or cookie fallback).
 * Cart is an array of ['id' => int, 'qty' => int].
 *
 * @return array
 */
function getCart(): array
{
    $key = getCartKey();

    if (!isset($_SESSION['carts']) || !is_array($_SESSION['carts'])) {
        $_SESSION['carts'] = [];
    }
    if (!isset($_SESSION['carts'][$key]) || !is_array($_SESSION['carts'][$key])) {
        $_SESSION['carts'][$key] = [];
    }

    // Nếu giỏ trong session đang rỗng nhưng có cookie thì khôi phục
    $cookieName = getCartCookieName();
    if (empty($_SESSION['carts'][$key]) && isset($_COOKIE[$cookieName])) {
        $data = json_decode($_COOKIE[$cookieName], true);
        if (is_array($data)) {
            $_SESSION['carts'][$key] = $data;
        }
    }

    // Ensure consistent structure
    $_SESSION['carts'][$key] = array_values(array_map(function ($item) {
        return [
            'id' => isset($item['id']) ? (int)$item['id'] : 0,
            'qty' => isset($item['qty']) ? max(1, (int)$item['qty']) : 1,
        ];
    }, $_SESSION['carts'][$key]));

    return $_SESSION['carts'][$key];
}

/**
 * Save cart to session and set cookie for persistence.
 *
 * @param array $cart
 * @return void
 */
function saveCart(array $cart): void
{
    $key = getCartKey();

    // Normalize structure and drop invalid entries
    $cart = array_values(array_filter(array_map(function ($item) {
        $id = isset($item['id']) ? (int)$item['id'] : 0;
        $qty = isset($item['qty']) ? (int)$item['qty'] : 0;
        if ($id <= 0 || $qty <= 0) {
            return null;
        }
        return ['id' => $id, 'qty' => $qty];
    }, $cart)));

    if (!isset($_SESSION['carts']) || !is_array($_SESSION['carts'])) {
        $_SESSION['carts'] = [];
    }

    $_SESSION['carts'][$key] = $cart;

    $cookieName = getCartCookieName();
    setcookie($cookieName, json_encode($cart), time() + CART_COOKIE_TTL, '/', '', false, true);
}

/**
 * Add product to cart (increments quantity if already exists).
 *
 * @param int $productId
 * @param int $qty
 * @return void
 */
function addToCart(int $productId, int $qty = 1): void
{
    if ($productId <= 0 || $qty <= 0) {
        return;
    }

    $cart = getCart();
    $found = false;
    foreach ($cart as &$item) {
        if ($item['id'] === $productId) {
            $item['qty'] += $qty;
            $found = true;
            break;
        }
    }
    unset($item);

    if (!$found) {
        $cart[] = ['id' => $productId, 'qty' => $qty];
    }

    saveCart($cart);
}

/**
 * Update quantity of an existing cart item.
 *
 * @param int $productId
 * @param int $qty
 * @return void
 */
function updateCartItem(int $productId, int $qty): void
{
    if ($productId <= 0) {
        return;
    }

    $cart = getCart();
    foreach ($cart as $index => $item) {
        if ($item['id'] === $productId) {
            if ($qty <= 0) {
                unset($cart[$index]);
            } else {
                $cart[$index]['qty'] = $qty;
            }
            break;
        }
    }
    saveCart($cart);
}

/**
 * Remove an item from the cart.
 *
 * @param int $productId
 * @return void
 */
function removeFromCart(int $productId): void
{
    if ($productId <= 0) {
        return;
    }
    $cart = getCart();
    $cart = array_filter($cart, function ($item) use ($productId) {
        return $item['id'] !== $productId;
    });
    saveCart($cart);
}

/**
 * Empty the cart.
 *
 * @return void
 */
function clearCart(): void
{
    $key = getCartKey();

    // Xóa trong session
    if (isset($_SESSION['carts'][$key])) {
        $_SESSION['carts'][$key] = [];
    }

    // Xóa cookie tương ứng
    $cookieName = getCartCookieName();
    if (isset($_COOKIE[$cookieName])) {
        setcookie($cookieName, '', time() - 3600, '/', '', false, true);
        unset($_COOKIE[$cookieName]);
    }
}

/**
 * Get cart totals based on product prices.
 *
 * @param array $productsById Map of productId => ['gia' => float, ...]
 * @param array|null $cart Optional cart array. If null, uses current session cart.
 * @return array [subtotal, shipping, vat, total]
 */
function calculateCartTotals(array $productsById, ?array $cart = null): array
{
    if ($cart === null) {
        $cart = getCart();
    }

    $subtotal = 0;
    foreach ($cart as $item) {
        $id = $item['id'];
        $qty = max(0, (int)$item['qty']);
        if ($qty <= 0) {
            continue;
        }
        $price = isset($productsById[$id]['gia']) ? (float)$productsById[$id]['gia'] : 0;
        $subtotal += $price * $qty;
    }

    // Shipping logic: miễn phí nếu subtotal >= 250.000
    $shipping = $subtotal === 0 ? 0 : ($subtotal >= 250000 ? 0 : 20000);
    $vat = 0; // Không tính phí VAT
    $total = max(0, $subtotal + $shipping);

    return [
        'subtotal' => $subtotal,
        'shipping' => $shipping,
        'vat' => $vat,
        'total' => $total,
    ];
}

/**
 * Flash messaging helper (stored in session).
 */
function flash(string $message): void
{
    $_SESSION['_flash_message'] = $message;
}

function getFlash(): ?string
{
    if (isset($_SESSION['_flash_message'])) {
        $msg = $_SESSION['_flash_message'];
        unset($_SESSION['_flash_message']);
        return $msg;
    }
    return null;
}