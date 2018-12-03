<!DOCTYPE html>
<html lang="en">
<head>
	<title>Davao City Payment Portal</title>
	<asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.css')}" type="text/css">
	<script src='https://www.google.com/recaptcha/api.js'></script>
	<style type="text/css">
            .col-8 {
                padding-left: 50px;
                padding-right: 50px;
            }
            .row {
				margin-bottom: 1em;
            }
        </style>
</head>
<body>
	<div class="container-fluid">
	  <div class="wrapper">
		  	<g:img class="images mx-auto d-block" dir="images" file="banner4.png" />
		  	<h2 style="text-align: center;">Welcome to Davao City Payment Portal</h2>
		  	<g:if test="${flash.message}">
	            <div style="background-color:#F3F8FC; color:#0967BD; border: solid thin; padding: 10px;" clas="material-icons"><i class="material-icons" style="color:#0967BD; font-size:15px;">error</i> ${flash.message}</div>
	        </g:if>
	        <g:if test="${flash.error}">
	            <div style="background-color:#FFF3F3; color:red; border: solid thin; padding: 10px;" clas="material-icons"><i class="material-icons" style="color:red; font-size:15px;">warning</i> ${flash.error}</div>
	        </g:if>
		  	<br>
		  	<g:if test ="${message}">
		  		<div style="background-color:#FFF3F3; color:red; border: solid thin; padding: 10px;" clas="material-icons"><i class="material-icons" style="color:red; font-size:15px;">warning</i> ${message}</div>
			</g:if>
			<g:if test ="${messageSuccess}">
				<div style="background-color:#F3F8FC; color:#0967BD; border: solid thin; padding: 10px;" clas="material-icons"><i class="material-icons" style="color:#0967BD; font-size:15px;">error</i> ${messageSuccess}</div>
				<br>
				<div style="background-color:#F3F8FC; color:#0967BD; border: solid thin; padding: 10px;" clas="material-icons"><i class="material-icons" style="color:#0967BD; font-size:15px;">error</i> Kindly go to the City Treasurer Office for your Official Receipt</div>
			 </g:if>

			<g:if test ="${params.retrievalReferenceCode}">
				  <div class="row">
	                <div class="col-4"></div>
	                <div class="col-4"> </div>
	            </div>
	            <div class="row">
	                <div class="col-2"></div>
	                <div class="col-8" style="background-color: #FFFFFF; border-style: none; margin-left:-30px;">
	                       <h4 class="text-center">Summary of the Transaction</h4>
	                </div>
	            </div>
	            <div class="row" style="margin-bottom: 9px;">
	                <div class="col-2"></div>
	                <div class="col-8" style="background-color: #FFFFFF; border-style: none;">
	                    <div class="row">
	                        <label for="senderFirstName">Merchant Name:</label>
	                        <input type="text" readonly="readonly" class="form-control" value="${params.merchantName}" />
	                    </div>
	                    <div class="row">
	                        <label for="senderFirstName">Reference Code:</label>
	                        <input type="text" readonly="readonly" class="form-control" value="${params.referenceCode}" />
	                    </div>
	                    <div class="row">
	                        <label for="senderFirstName">Retrieval Reference Code:</label>
	                        <input type="text" readonly="readonly" class="form-control" value="${params.retrievalReferenceCode}" />
	                    </div>
	                    <div class="row">
	                        <label for="senderFirstName">Amount:</label>
	                        <input type="text" readonly="readonly" class="form-control" value="Php ${params.amount}" />
	                    </div>
	                    <div class="row">
	                        <label for="senderFirstName">Service Charge Fee:</label>
	                        <input type="text" readonly="readonly" class="form-control" value="Php ${params.serviceChargeFee}" />
	                    </div>
	                    <div class="row">
	                        <label for="senderFirstName">Total:</label>
	                        <input type="text" readonly="readonly" class="form-control" value="Php ${params.total}" />
	                    </div>
	                    <div class="row">
	                        <label for="senderFirstName">Date/Time:</label>
	                        <input type="text" readonly="readonly" class="form-control" value="${params.date}" />
	                    </div>
	                </div>
	            </div>
	        </g:if>

            <div class="text-center" style="margin-top:2%; margin-left:-50px;"><g:link class="btn btn-primary" action="index">Click here to make another transaction</g:link>
            </div>
            <div><br> <br> <br></div>
	  </div>
	</div>
</body>
</html>
