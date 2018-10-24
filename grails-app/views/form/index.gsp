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
	<script src='https://www.google.com/recaptcha/api.js'></script>
</head>
<body>
	<div class="container-fluid">
	  <div class="wrapper">
	  	<g:img class="images mx-auto d-block" dir="images" file="banner4.png" />
	  	%{-- <g:img class=" images mx-auto d-block" dir="images" file="davao_seal.png" /> --}%
	  	<h2 style="text-align: center;">Welcome to Davao City Payment Portal</h2>
	  	<g:if test="${flash.message}">
                <div style="background-color:#F3F8FC; color:#0967BD; border: solid thin; padding: 10px;" clas="material-icons" id="message"><i class="material-icons" style="color:#0967BD; font-size:15px;">error</i> ${flash.message}</div>
            </g:if>
            <g:if test="${flash.error}">
                <div style="background-color:#FFF3F3; color:red; border: solid thin; padding: 10px;" clas="material-icons" id="message"><i class="material-icons" style="color:red; font-size:15px;">warning</i> ${flash.error}</div>
            </g:if>
            <g:hasErrors bean="${form}">
			<ul role="alert"style="background-color:#FFF3F3; color:red; border: solid thin; padding: 10px;" clas="material-icons" id="message"><i class="material-icons" style="color:red; font-size:15px;">warning</i>
				<g:eachError bean="${form}" var="error">
				<g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/>
				</g:eachError>
			</ul>
			</g:hasErrors>
	  	<br>
		%{-- <form> --}%
			<g:form controller="form" action="save" enctype="multipart/form-data" method="post" >
		  <div class="form-group">
		    <label for="payorName">Payor Name</label>
		    <input type="text" name="payorName"class="form-control">
		  </div>
		  <div class="form-group">
		    <label for="email">Email Address</label>
		    <input type="email" name="email" class="form-control" aria-describedby="emailHelp">
		    %{-- <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small> --}%
		  </div>
		  <div class="form-group">
		    <label for="mobileNumber">Mobile Number</label>
		    <input type="text" name="mobileNumber" class="form-control" maxlength="13" placeholder="+63xxxxxxxxxx">
		  </div>
		  <div class="form-group">
		    <label for="typeOfFee">Type of Fee</label>
		    <select name="typeOfFee" required="required" class="form-control">
		      <option value="" disabled selected>Select type of fee</option>
		      <option value="BUSINESS">BUSINESS</option>
		      <option value="MISCELLANEOUS">MISCELLANEOUS</option>
		      <option value="REALPROPERTY">REALPROPERTY</option>
		    </select>
		  </div>
		  <div class="form-group">
		    <label for="optn">Enter your Online Payment Transaction Number (OPTN)</label>
		    <input  name="optn" type="text" class="form-control" maxlength="33" pattern="[0-9]{7}[-]{1}[0-9]{10}[-]{1}[0-9]{8}[-]{1}[0-9]{1}[-]{1}[0-9]{3}" placeholder="1234567-1234567890-12345678-1-123">
		  </div>
		  <br>
		  <div class="form-group">
		  	<div class="g-recaptcha" data-sitekey="6LfJkXYUAAAAAFRpa8Itf9zrxE_ZEILLbg2rJsOv"></div>
		  </div>
		  	<g:actionSubmit action="save" value="Proceed to Payment" class="btn btn-primary" />
		</g:form>
		%{-- </form> --}%

	  </div>
	</div>
</body>
</html>
