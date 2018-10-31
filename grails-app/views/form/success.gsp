<!DOCTYPE html>
<html lang="en">
<head>
	<title>Davao City Payment Portal</title>
	<asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.css')}" type="text/css">
	<script src='https://www.google.com/recaptcha/api.js'></script>
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
			<dvi role="alert"style="background-color:#FFF3F3; color:red; border: solid thin; padding: 10px;" clas="material-icons" id="message"><i class="material-icons" style="color:red; font-size:15px;">warning</i>
			<g:eachError bean="${form}" var="error">
			<g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/>
			</g:eachError>
		</div>
		</g:hasErrors>
	  	<br>
	  	<g:if test ="${message}">
	  		<div style="background-color:#FFF3F3; color:red; border: solid thin; padding: 10px;" clas="material-icons" id="message"><i class="material-icons" style="color:red; font-size:15px;">warning</i> ${message}</div>
		</g:if>
		<g:if test ="${messageSuccess}">
			<div style="background-color:#F3F8FC; color:#0967BD; border: solid thin; padding: 10px;" clas="material-icons" id="message"><i class="material-icons" style="color:#0967BD; font-size:15px;">error</i> ${messageSuccess}</div>
		 </g:if>
	  </div>
	</div>
</body>
</html>
