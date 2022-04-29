/* Data: 13/04/2022 
 * Autor: Mayara Barranco da Silva (Everymind) - mayara.silva@everymind.com.br
 * Classe de Testes: ContentDocumentLinkTriggerTest
 */
public class ContentDocumentLinkTH {

    public void addAttachmentInRelatedObj(ContentDocumentLink cdl){
    
        MessagingSession ms = [SELECT Account__c, CaseId, LeadId, OpportunityId FROM MessagingSession WHERE Id = :cdl.linkedEntityId];
        
        ContentDocumentLink cdlNew = new ContentDocumentLink();
        cdlNew.ContentDocumentId = cdl.ContentDocumentId;
        
        if(ms.CaseId != null)
            cdlNew.LinkedEntityId = ms.CaseId;
        else if(ms.LeadId != null)
            cdlNew.LinkedEntityId = ms.LeadId;
        else if(ms.OpportunityId != null)
            cdlNew.LinkedEntityId = ms.OpportunityId;
        else if(ms.Account__c != null)
            cdlNew.LinkedEntityId = ms.Account__c;
        
        Database.insert(cdlNew);
    }
}