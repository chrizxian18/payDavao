package paydavao

class Form {

    String payorName
    String email
    String mobileNumber
    String typeOfFee
    String optn
    Date dateCreated = new Date()

    static constraints = {
    	payorName(nullable:true)
	    email(nullable:true)
	    mobileNumber(nullable:true)
	    typeOfFee(nullable:false)
	    optn(nullable:false)
    }

}
