let qtyInput = document.getElementById("quantity");
let qtyAddCart = document.getElementById("qty-add-cart");
let qtyBuyNow = document.getElementById("qty-buy-now");

let plusButton = document.querySelector(".plus");
let minusButton = document.querySelector(".minus");

function syncQuantity() {
    var val = Math.max(1, Math.min(100, parseInt(qtyInput.value) || 1));
    qtyInput.value = val;
    if (qtyAddCart) qtyAddCart.value = val;
    if (qtyBuyNow) qtyBuyNow.value = val;
}

plusButton.addEventListener("click", () => {
    if(parseInt(qtyInput.value) <= 100){
        qtyInput.value++;
        syncQuantity();
    }
});

minusButton.addEventListener("click", () => {
    if(parseInt(qtyInput.value) > 1){
        qtyInput.value--;
        syncQuantity();
    }
});

// Đồng bộ số lượng khi submit form (để chắc chắn)
document.getElementById("form-add-cart")?.addEventListener("submit", syncQuantity);
document.getElementById("form-buy-now")?.addEventListener("submit", syncQuantity);