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

qtyInput.addEventListener("keydown", (e) => {
    const allowed = ["Backspace", "Delete", "ArrowLeft", "ArrowRight", "Tab"];
    if (allowed.includes(e.key)) return;
    if (!/^\d$/.test(e.key)) e.preventDefault();
});

qtyInput.addEventListener("input", () => {
    qtyInput.value = qtyInput.value.replace(/[^0-9]/g, "");
});

qtyInput.addEventListener("change", () => {
    syncQuantity();
});


document.getElementById("form-add-cart")?.addEventListener("submit", syncQuantity);
document.getElementById("form-buy-now")?.addEventListener("submit", syncQuantity);