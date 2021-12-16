/*
    This class is used to represent a response returned from the HTTP REST API endpoint
*/

class RESTAPIResponse {
    bool Success = false;
    String Content = '';
    RESTAPIResponse(this.Success, this.Content);
}