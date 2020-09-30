import grails.util.BuildSettings
import grails.util.Environment
import org.springframework.boot.logging.logback.ColorConverter
import org.springframework.boot.logging.logback.WhitespaceThrowableProxyConverter

import java.nio.charset.Charset

conversionRule 'clr', ColorConverter
conversionRule 'wex', WhitespaceThrowableProxyConverter

// See http://logback.qos.ch/manual/groovy.html for details on configuration
appender('STDOUT', ConsoleAppender) {
    encoder(PatternLayoutEncoder) {
        charset = Charset.forName('UTF-8')

        pattern =
                '%clr(%d{yyyy-MM-dd HH:mm:ss.SSS}){faint} ' + // Date
                        '%clr(%5p) ' + // Log level
                        '%clr(---){faint} %clr([%15.15t]){faint} ' + // Thread
                        '%clr(%-40.40logger{39}){cyan} %clr(:){faint} ' + // Logger
                        '%m%n%wex' // Message
    }
}

def targetDir = BuildSettings.TARGET_DIR
if (Environment.isDevelopmentMode() && targetDir != null) {
    appender("FULL_STACKTRACE", FileAppender) {
        file = "${targetDir}/stacktrace.log"
        append = true
        encoder(PatternLayoutEncoder) {
            pattern = "%level %logger - %msg%n"
        }
    }
    logger("StackTrace", ERROR, ['FULL_STACKTRACE'], false)
}
root(ERROR, ['STDOUT'])

// always a good idea to add an on console status listener
statusListener(OnConsoleStatusListener)

def appenderList = ["ROLLING"]
def WEBAPP_DIR = "."
def consoleAppender = true;

// does hostname match pixie or orion?
if (hostname =~ /pixie|orion/) {
  WEBAPP_DIR = "/opt/myapp"     
  consoleAppender = false   
} else {
  appenderList.add("CONSOLE")
}

if (consoleAppender) {
  appender("CONSOLE", ConsoleAppender) {
    encoder(PatternLayoutEncoder) {
      pattern = "%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n"
    }
  }
}

appender("ROLLING", RollingFileAppender) {
  encoder(PatternLayoutEncoder) {
    Pattern = "%d %level %thread %mdc %logger - %m%n"
  }
  rollingPolicy(TimeBasedRollingPolicy) {
    FileNamePattern = "${WEBAPP_DIR}/log/payDAvao-%d{yyyy-MM-dd}.log.zip"
  }
}

root(INFO, appenderList)

