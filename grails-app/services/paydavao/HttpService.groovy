package paydavao

import grails.gorm.transactions.Transactional
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import groovy.json.*
import grails.converters.JSON
import org.apache.commons.codec.digest.DigestUtils;
import static java.util.Calendar.*;


@Transactional
class HttpService {




    def serviceMethod() {

    }

    def verifyPaymentDetails(params) {

    	println "verifyPaymentDetails.params:" + params
    	def refnum = params.optn
		def type = params.typeOfFee
		def provider = "DBP"
		def tokenid = "489a6ac47fb47d1ddea52b39fac1bb14"
        String payload = "refnum=${refnum}&type=${type}&provider=${provider}&tokenid=${tokenid}"
        println "payload:" + payload
        HttpClient client = null;
        PostMethod method = null;
        String result = "";
        client = new HttpClient();
        method = new PostMethod("http://122.2.3.140/verify.php");
        org.apache.commons.httpclient.methods.StringRequestEntity requestEntity = new org.apache.commons.httpclient.methods.StringRequestEntity(payload, "application/x-www-form-urlencoded", "UTF-8");
        try {
    		method.setRequestEntity(requestEntity);
    		client.executeMethod(method);                
    		result = method.getResponseBodyAsString();
            println "result of method:" + result
    		def slurper = new groovy.json.JsonSlurper(type: JsonParserType.LAX)
    		def parsedData = slurper.parseText(result)
            println "parsedData:" + parsedData
    		return parsedData
        }
        catch(Exception e) {
            println "Exception:" + e
        }
    }


     def postPaymentDetails(params) {

        println "postPaymentDetails.params:" + params
        def refnum = params.referenceCode
        def amount = params.total //amount collected
        def date = new Date()
        def transactiondate = date.format("yyyy-MM-dd' 'HH:mm:ss")
        def transactionid = params.retrievalReferenceCode
        def type = params.serviceType
        def provider = "DBP"
        def tokenid = "489a6ac47fb47d1ddea52b39fac1bb14"
        String payload = "refnum=${refnum}&amount=${amount}&transactiondate=${transactiondate}&transactionid=${transactionid}&type=${type}&provider=${provider}&tokenid=${tokenid}"
        println "payload:" + payload
        HttpClient client = null;
        PostMethod method = null;
        String result = "";
        client = new HttpClient();
        method = new PostMethod("http://122.2.3.140/postpayment.php");
        org.apache.commons.httpclient.methods.StringRequestEntity requestEntity = new org.apache.commons.httpclient.methods.StringRequestEntity(payload, "application/x-www-form-urlencoded", "UTF-8");
        try {
            method.setRequestEntity(requestEntity);
            client.executeMethod(method);                
            result = method.getResponseBodyAsString();
            println "result of method:" + result
            def slurper = new groovy.json.JsonSlurper(type: JsonParserType.LAX)
            def parsedData = slurper.parseText(result)
            println "response after posting paymentDetails:" + parsedData
            return parsedData
        }
        catch(Exception e) {
            println "Exception:" + e
        }
    }

    def verifyCaptcha(params) {
        println "verifyCaptcha.params:" + params
        def response = params
        def secret = "6LfJkXYUAAAAAP6GARbw0xNttpYg1vdWUZKVtrZV"
        String payload = "response=${params}&secret=${secret}"
        HttpClient client = null;
        PostMethod method = null;
        String result = "";
        client = new HttpClient();
        method = new PostMethod("https://www.google.com/recaptcha/api/siteverify");
        org.apache.commons.httpclient.methods.StringRequestEntity requestEntity = new org.apache.commons.httpclient.methods.StringRequestEntity(payload, "application/x-www-form-urlencoded", "UTF-8");
        try {
            method.setRequestEntity(requestEntity);
            client.executeMethod(method);                
            result = method.getResponseBodyAsString();
            println "result of method:" + result
            def slurper = new groovy.json.JsonSlurper()
            def parsedData = slurper.parseText(result)
            return parsedData
        }
        catch(Exception e) {
            println "Exception:" + e
        }
    }

    def sendToIpg(params, response) {
        println "params in sendToIpg:" + params
        println "response in sendToIpg:" + response
        def amount = response?.amount
        def referenceCode = params?.optn
        def serviceType = params?.typeOfFee
        def terminalID = "52"
        def securityToken = generateSecurityToken(amount, terminalID, referenceCode)
        def payloadMap = [:]
         payloadMap.amount = amount
         payloadMap.terminalID = terminalID
         payloadMap.referenceCode = referenceCode
         payloadMap.serviceType = serviceType
         payloadMap.securityToken = securityToken
        println "payload:" + payloadMap
        return payloadMap
    }

    // def testSendToIpg(params) {
    //     def amount = "3399.66"
    //     // def referenceCode = "765432100006666000530192350803423"
    //     def referenceCode = params.id
    //     def serviceType = "REALPROPERTY"
    //     def terminalID = "52"
    //     def securityToken = generateSecurityToken(amount, terminalID, referenceCode)
    //     def payloadMap = [:]
    //      payloadMap.amount = amount
    //      payloadMap.terminalID = terminalID
    //      payloadMap.referenceCode = referenceCode
    //      payloadMap.serviceType = serviceType
    //      payloadMap.securityToken = securityToken
    //     println "payload:" + payloadMap
    //     return payloadMap
    // }


    def generateSecurityToken = { amount, terminalID, referenceCode ->
        def transactionKey = "ae19f5a6575d4eeceacbec06c17477a5e922c249"
        String requestToken = DigestUtils.sha1Hex(terminalID + referenceCode + amount + "{" + transactionKey + "}");
        println "requestToken:" + requestToken
        return requestToken
    }

     def generateResponseToken(params, requestSecurityToken) {
        println "generateResponseToken.params:" + params
        println "generateResponseToken.requestSecurityToken:" + requestSecurityToken
        def requestToken = requestSecurityToken 
        def amount = params.amount
        def retrievalReferenceCode = params.retrievalReferenceCode
        def transactionKey = "ae19f5a6575d4eeceacbec06c17477a5e922c249"
        // String responseToken = DigestUtils.sha1Hex(requestToken + amount + retrievalReferenceCode + "{" + transactionKey + "}");
        String responseToken = DigestUtils.sha1Hex(requestToken + "{" + transactionKey + "}");
        println "responseToken:" + responseToken
        return responseToken
    }
}
