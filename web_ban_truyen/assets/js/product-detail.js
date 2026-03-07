let qtyInput = document.getElementById("quantity");

let plusButton = document.querySelector(".plus");
let minusButton = document.querySelector(".minus");

plusButton.addEventListener("click", () => {
    if(parseInt(qtyInput.value) <= 100){
        qtyInput.value++;
    }
});

minusButton.addEventListener("click", () => {
    if(parseInt(qtyInput.value) > 1){
        qtyInput.value--;
    }
});