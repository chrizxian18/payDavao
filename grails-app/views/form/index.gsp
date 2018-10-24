<!DOCTYPE html>
<html lang="en">
<head>
	%{-- <meta name="layout" content="main" /> --}%
	<title>Davao City Payment Portal</title>
	<asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.css')}" type="text/css">
	<style type="text/css">
		.wrapper {

			margin-top: 2%;
			margin-left: 20%;
			margin-right: 20%;
		}

		.images {
		    max-width: 100%;
    height: auto;
    width: auto\9; /* ie8 */
		    margin-bottom: 1em;
		}
	</style>
</head>
<body>
	<div class="container-fluid">
	  <div class="wrapper">
	  	<g:img class="images mx-auto d-block" dir="images" file="banner4.png" />
	  	%{-- <g:img class=" images mx-auto d-block" dir="images" file="davao_seal.png" /> --}%
	  	<h2 style="text-align: center;">Welcome to Davao City Payment Portal</h2>
	  	<br>
		<form>
		  <div class="form-group">
		    <label for="payorName">Payor Name</label>
		    <input type="text" class="form-control">
		  </div>
		  <div class="form-group">
		    <label for="email1">Email Address</label>
		    <input type="email" class="form-control" aria-describedby="emailHelp">
		    %{-- <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small> --}%
		  </div>
		  <div class="form-group">
		    <label for="payorName">Mobile Number</label>
		    <input type="text" class="form-control" maxlength="13" placeholder="+63xxxxxxxxxx">
		  </div>
		  <div class="form-group">
		    <label for="typeOfFee">Type of Fee</label>
		    <select required="required" class="form-control">
		      <option value="" disabled selected>Select type of fee</option>
		      <option value="BUSINESS">BUSINESS</option>
		      <option value="MISCELLANEOUS">MISCELLANEOUS</option>
		      <option value="REALPROPERTY">REALPROPERTY</option>
		    </select>
		  </div>
		  <div class="form-group">
		    <label for="OPTN">Enter your Online Payment Transaction Number (OPTN)</label>
		    <input  type="text" class="form-control" maxlength="33" pattern="[0-9]{7}[-]{1}[0-9]{10}[-]{1}[0-9]{8}[-]{1}[0-9]{1}[-]{1}[0-9]{3}" placeholder="1234567-1234567890-12345678-1-123">
		  </div>
		  <br>
		  	<g:actionSubmit action="save" value="Proceed to Payment" class="btn btn-primary" />
		</form>
	  </div>
	</div>
</body>
</html>
