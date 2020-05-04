package paydavao

import grails.gorm.transactions.Transactional
import java.util.UUID;


@Transactional
class UniqueStringGeneratorService {

    def serviceMethod() {

    }

        

    def generateDateWithUUIDString(){
        String uuid = generateUUID()
        def sdformat = new java.text.SimpleDateFormat("yyyyMMddHHmmss")
        def today = new Date()
        def dateString = sdformat.format(today)
        def dateWithUUIDString = dateString + "-" + uuid
        log.info "dateWithUUIDString:" + dateWithUUIDString
        return dateWithUUIDString
    }


    public static String generateUUID() {
        return UUID.randomUUID().toString();
    }
}
