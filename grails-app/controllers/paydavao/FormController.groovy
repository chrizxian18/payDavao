package paydavao

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*
import org.apache.commons.codec.digest.DigestUtils;

class FormController {

    FormService formService
    HttpService httpService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index() {

    }

    // def index(Integer max) {
    //     params.max = Math.min(max ?: 10, 100)
    //     respond formService.list(params), model:[formCount: formService.count()]
    // }

    // def show(Long id) {
    //     respond formService.get(id)
    // }

    // def create() {
    //     respond new Form(params)
    // }

    def save(Form form) {
        if (form == null) {
            notFound()
            return
        }
        println "params:" + params
        def captcha = params.get("g-recaptcha-response")
        def captchaResponse = httpService.verifyCaptcha(captcha)
        println "captchaResponse:" + captchaResponse

        if (captchaResponse.success == true) {
            def response = httpService.verifyPaymentDetails(params)
            println "response of httpService.verifyPaymentDetails:" + response
            def result = response?.get("Result")
            println "result of verfication:" + result
            if (response == null) {
                flash.error = "Failed to access the City Government Gateway Server"
                println "Failed to access the City Government Gateway Server"
                redirect action:"index"
            }
            else if (result == 1) {
                
                try {
                    println "params when saving" + params
                    formService.save(form)
                    def ipgResult = httpService.sendToIpg(params,response)
                    // redirect(url:"http://192.168.48.114:9090/transaction/verify?amount=${ipgResult.amount}&terminalID=${ipgResult.terminalID}&referenceCode=${ipgResult.referenceCode}&securityToken=${ipgResult.securityToken}&serviceType=${ipgResult.serviceType}")
                    redirect(url:"https://testipg.apollo.com.ph:8443/transaction/verify?amount=${ipgResult.amount}&terminalID=${ipgResult.terminalID}&referenceCode=${ipgResult.referenceCode}&securityToken=${ipgResult.securityToken}&serviceType=${ipgResult.serviceType}")

                } catch (ValidationException e) {
                	println "ValidationException:" + e
                    respond form.errors, view:'index'
                    return
                }
                    println "success, params:" + params + "form: ${form}"
            } 
            else {
                flash.error = "Error: Invalid Reference Number!" //+ response.message
                println "Error:" + response.message
                redirect action:"index"
            }
        }
        else {
            flash.error = "Prove that you are not a robot!" 
                redirect action:"index"
        }
    }


    // def test() {

    //    def ipgResult = httpService.testSendToIpg()
    //    println "ipgResult of test:" + ipgResult
    //    println "${ipgResult.amount}"
    //    // redirect(url:"http://192.168.48.114:9090/transaction/verify?amount=${ipgResult.amount}&terminalID=${ipgResult.terminalID}&referenceCode=${ipgResult.referenceCode}&securityToken=${ipgResult.securityToken}&serviceType=${ipgResult.serviceType}")
    //    redirect(url:"https://testipg.apollo.com.ph:8443/transaction/verify?amount=${ipgResult.amount}&terminalID=${ipgResult.terminalID}&referenceCode=${ipgResult.referenceCode}&securityToken=${ipgResult.securityToken}&serviceType=${ipgResult.serviceType}")
    // }


    def success(params) {
        println "params in successPage:" + params
        def message = ""
        // ['referenceCode':'M8751118028067', 'serviceType':'MISCELLANEOUS', 'amount':'230.00', 'serviceChargeFeeText':'PHP4.60', 'securityToken':'971dbdc497b7006e01464a6c78394623a99f015f', 'disableEmailClient':'false', 'merchantName':'LGU DAVAO - IPG', 'serviceFeeLabel':'Service Fee', 'serviceChargeFee':'4.60', 'total':'234.6', 'interceptor':'verify', 'retrievalReferenceCode':'830416029514', 'message':'Successful approval/completion.', 'action':'success', 'format':null, 'controller':'form']
        if (params.retrievalReferenceCode) {
            def amount = params.amount
            def terminalID = "52"
            def referenceCode = params.referenceCode
            def requestSecurityToken = httpService.generateSecurityToken(amount, terminalID, referenceCode)
            println "requestSecurityToken:" + requestSecurityToken
            def result = httpService.generateResponseToken(params, requestSecurityToken)
            println "result:" + result
            if (result != params?.securityToken) {
                message = "Invalid securityToken!"
                [message:message]
            }
            else {
                def response = httpService.postPaymentDetails(params)
                println "response:" + response
                message = "Payment Successful"
                 [messageSuccess:message]
            }
        }
        else {
            println "No RRN"
            message = "RRN not found!"
            [message:message]
        }

    }

    def fail(params) {
        println "params in failPage:" + params
        [message:params.message]
    }



    // def edit(Long id) {
    //     respond formService.get(id)
    // }

    // def update(Form form) {
    //     if (form == null) {
    //         notFound()
    //         return
    //     }

    //     try {
    //         formService.save(form)
    //     } catch (ValidationException e) {
    //         respond form.errors, view:'edit'
    //         return
    //     }

    //     request.withFormat {
    //         form multipartForm {
    //             flash.message = message(code: 'default.updated.message', args: [message(code: 'form.label', default: 'Form'), form.id])
    //             redirect form
    //         }
    //         '*'{ respond form, [status: OK] }
    //     }
    // }

    // def delete(Long id) {
    //     if (id == null) {
    //         notFound()
    //         return
    //     }

    //     formService.delete(id)

    //     request.withFormat {
    //         form multipartForm {
    //             flash.message = message(code: 'default.deleted.message', args: [message(code: 'form.label', default: 'Form'), id])
    //             redirect action:"index", method:"GET"
    //         }
    //         '*'{ render status: NO_CONTENT }
    //     }
    // }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'form.label', default: 'Form'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
