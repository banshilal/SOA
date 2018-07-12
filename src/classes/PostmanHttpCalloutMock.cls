@isTest
global class PostmanHttpCalloutMock implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"args":{"foo1":"bar1","foo2":"bar2"},"headers":{"host":"postman-echo.com","accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8","accept-encoding":"gzip, deflate, br","accept-language":"en-US,en;q=0.9","upgrade-insecure-requests":"1","user-agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36","x-forwarded-port":"443","x-forwarded-proto":"https"},"url":"https://postman-echo.com/get?foo1=bar1&foo2=bar2"}');
        response.setStatusCode(200);
        return response; 
    }
}