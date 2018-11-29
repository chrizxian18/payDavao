<!DOCTYPE html>
<html lang="en">
<head>
	<title>Davao City Payment Portal</title>
	<asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.css')}" type="text/css">
	<script src='https://www.google.com/recaptcha/api.js'></script>
	<asset:javascript src="application.js"/>
</head>
<body>
	<div class="container-fluid">
	  <div class="wrapper">
	  	<g:img class="images mx-auto d-block" dir="images" file="banner4.png" />
	  	<h2 style="text-align: center;">Welcome to Davao City Payment Portal</h2>
	  	<g:if test="${flash.message}">
            <div style="background-color:#F3F8FC; color:#0967BD; border: solid thin; padding: 10px;" clas="material-icons" id="message"><i class="material-icons" style="color:#0967BD; font-size:15px;">error</i> ${flash.message}</div>
        </g:if>
        <g:if test="${flash.error}">
            <div style="background-color:#FFF3F3; color:red; border: solid thin; padding: 10px;" clas="material-icons" id="message"><i class="material-icons" style="color:red; font-size:15px;">warning</i> ${flash.error}</div>
        </g:if>
        <g:hasErrors bean="${form}">
			<div role="alert"style="background-color:#FFF3F3; color:red; border: solid thin; padding: 10px;" clas="material-icons" id="message"><i class="material-icons" style="color:red; font-size:15px;">warning</i>
			<g:eachError bean="${form}" var="error">
			<g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/>
			</g:eachError>
			</div>
		</g:hasErrors>
	  	<br>
		<g:form controller="form" enctype="multipart/form-data" method="post" >
		  <div class="form-group">
		    <label for="payorName">Payor Name</label>
		    <input required="required" type="text" name="payorName"class="form-control" value="${params.payorName}">
		  </div>
		  <div class="form-group">
		    <label for="email">Email Address</label>
		    <input required="required" type="email" name="email" class="form-control" aria-describedby="emailHelp">
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
		    <label for="optn">Enter your Online Payment Transaction Number (OPTN) / Reference Number</label>
		    <input  required="required" name="optn" type="text" class="form-control" maxlength="29">
		  </div>
		  <br>
		  <div class="form-group">
		  	<div class="g-recaptcha" data-sitekey="6LfJkXYUAAAAAFRpa8Itf9zrxE_ZEILLbg2rJsOv"></div>
		  </div>
		  	
		  	<!-- Button trigger modal -->
			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#confirmSubmitModal">
			  Proceed to Payment
			</button>
			<!-- Modal -->
			<div class="modal fade" id="confirmSubmitModal" tabindex="-1" role="dialog" aria-labelledby="confirmSubmitModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="confirmSubmitModalLabel">Proceed to Payment</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			        Are you sure?
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
			        %{-- <button type="button" class="btn btn-primary">Save changes</button> --}%
			        <g:actionSubmit action="save" value="Yes" class="btn btn-primary" />
			      </div>
			    </div>
			  </div>
			</div>
			%{-- End Modal --}%

		</g:form>

		<!-- Footer -->
		<footer class="page-footer font-small special-color-dark pt-4">

	    <!-- Copyright -->
	    <div class="footer-copyright text-center py-3">
	      Please be advised that payment cut-off time is at 11pm on banking days.
	    </div>
	    <!-- Copyright -->

		</footer>
		<!-- Footer -->

	  </div>
	</div>
</body>
</html>
