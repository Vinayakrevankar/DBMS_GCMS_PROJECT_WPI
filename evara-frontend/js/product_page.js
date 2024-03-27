$(document).ready(function() {

    const urlParams = new URLSearchParams(window.location.search);

    const productID = urlParams.get("product");

    $.get(`http://localhost:3004/api/product/${productID}`, function (data, status) {
        if (status === 'success') {
            const product = data.payload[0];
            console.log(product);
            // Populate the update form with existing data
            $('#product_title').text(product.productName);
            $('#product_desc').text(product.description);
            $('#image_main').attr('src', product.imageURL);
            $('#image_thumbnail').attr('src', product.imageURL);
            
        } else {
            // $('#userData').html('<p>User data not found</p>');
        }
    });
});