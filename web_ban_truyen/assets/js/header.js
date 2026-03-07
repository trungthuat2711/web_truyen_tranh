function checkSearch(){
    let keyword = document.querySelector('input[name="keyword"]').value.trim();

    if(keyword === ""){
        return false; // không submit
    }

    return true;
}