package paydavao

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class FormController {

    FormService formService

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

        try {
            formService.save(form)
        } catch (ValidationException e) {
        	println e
            respond form.errors, view:'index'
            return
        }

        // request.withFormat {
            // form multipartForm {

                // flash.message = message(code: 'default.created.message', args: [message(code: 'form.label', default: 'Form'), form.id])
                flash.message = "Payment Successful"
                println "test:" + params + "${form}"
                redirect action:"index"
            // }
            // '*' { respond form, [status: CREATED] }
        // }
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
