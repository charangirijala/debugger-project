@RestResource(urlMapping='/CaseManagement/v1/*')
global with sharing class CaseMgmtService {
  @HttpPost
  global static String attachPic() {
    RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;

    Id caseId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);
    Blob picture = req.requestBody;
    Attachment a = new Attachment(
      ParentId = caseId,
      Body = picture,
      ContentType = 'image/jpg',
      Name = 'Picture'
    );

    insert a;

    return a.Id;
  }
}