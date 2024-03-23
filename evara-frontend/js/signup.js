$(document).ready(function () {

    $('#email_signup').on('blur', function () {
        var email = $(this).val();
        if (!isValidEmail(email)) {
            $('#emailsignupError').text('Please enter a valid email address.');
            return false;
        } else {
            $('#emailsignupError').text('');
        }
    });

    $('#password_signup').on('blur', function () {
        var password = $(this).val();
        if (!isValidPassword(password)) {
            $('#passwordError').text('Please enter a valid password.');
            return false;
        } else {
            $('#passwordError').text('');
        }
    });

    $('#confirmPassword').on('blur', function () {
        var confirmPassword = $(this).val();
        var password = $('#password_signup').val()
        if (password !== confirmPassword) {
            $('#confirmPasswordError').text('Passwords do not match.');
            return false;
        } else {
            $('#confirmPasswordError').text('');
        }
    });

    $('#dob').on('blur', function () {
        var dob = $(this).val();
        $('#dobError').text('');
        if (!isValidDOB(dob)) {
            $('#dobError').text('Date of birth cannot be in future.');
        } else {
            $('#dobError').text('');
        }
    });

    $('#zipcode').on('blur', function () {
        var zipcode = $(this).val();
        $('#zipcodeError').text('');
        if (!isValidZipcode(zipcode)) {
            $('#zipcodeError').text('Please enter a valid zip code.');
        } else {
            $('#zipcodeError').text('');
        }
    });

    $('#phone').on('blur', function () {
        var phone = $(this).val();
        $('#phoneError').text('');
        if (!isValidPhoneNumber(phone)) {
            $('#phoneError').text('Please enter a valid phone number.');
        } else {
            $('#phoneError').text('');
        }
    });

    $('#signupForm').submit(function (e) {
        e.preventDefault(); 
        var confirmPassword = $('#confirmPassword').val();

        var formData = {
            email: $('#email_signup').val(),
            password: $('#password_signup').val(),
            firstname: $('#firstname').val(),
            lastname: $('#lastname').val(),
            dob_string: $('#dob').val(),
            address: $('#address').val(),
            zipcode: parseInt($('#zipcode').val(), 10),
            phone: parseInt($('#phone').val(), 10),
            phonetype: 'mobile',
            isCustomer: 1,
            isSuperAdmin: 0
        };

        if (!isValidString(formData.firstname)) {
            $('#firstnameError').text('Please enter a valid first name.');
            return false;
        } else {
            $('#firstnameError').text('');
        }

        if (!isValidString(formData.lastname)) {
            $('#lastnameError').text('Please enter a valid last name.');
            return false;
        } else {
            $('#lastnameError').text('');
        }

        if (!isValidString(formData.address)) {
            $('#addressError').text('Please enter a valid address.');
            return false;
        } else {
            $('#addressError').text('');
        }
        console.log(formData);

        $.ajax({
            type: 'POST',
            url: 'http://localhost:3004/api/account/signup/',
            contentType: 'application/json',
            data: JSON.stringify(formData),
            success: function (response) {
                console.log('Signup successful:', response);
                window.location.href = 'page-account.html';
            },
            error: function (error) {
                console.error('Signup error:', error);
                $('#errorMessage').text(error.responseText);
            }
        });
    });
});

function isValidEmail(email) {
    var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}
function isValidPassword(password) {
    return password.length >= 6;
}

function isValidString(value) {
    return value.trim() !== '';
}

function isValidZipcode(zipcode) {
    return /^\d{5}$/.test(zipcode);
}

function isValidPhoneNumber(phno) {
    return /^\d{10}$/.test(phno);
}

function isValidDOB(dobString) {
    var dob = new Date(dobString);
    var currentDate = new Date();
    if (dob > currentDate) {
      return false;
    }
    return true;
}
