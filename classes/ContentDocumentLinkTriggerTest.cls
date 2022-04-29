/* Data: 13/04/2022 
 * Autor: Mayara Barranco da Silva (Everymind) - mayara.silva@everymind.com.br
 * Classes: ContentDocumentLinkTrigger
 * 			ContentDocumentLinkTH
 */

@isTest
public class ContentDocumentLinkTriggerTest {
	
    @isTest(SeeAllData=true)
    public static void testAfterInsert(){

        RecordType accrt = [SELECT Id FROM RecordType WHERE DeveloperName = 'Prospect' LIMIT 1];
		Account a = new Account(Name = 'Teste', 
                                RecordType = accrt);
        insert(a);
        
        RecordType casert = [SELECT Id FROM RecordType WHERE DeveloperName = 'ChangesContractual' LIMIT 1];
        Case c = new Case(RecordType = casert,
                          AccountId = a.Id,
                          Status = 'Novo',
                          TypeChange__c = 'ALTERACAO DE RAZAO SOCIAL');
        
        insert(c);
        
        RecordType opprt = [SELECT Id FROM RecordType WHERE DeveloperName = 'Brinks_Corporativo' LIMIT 1];
        Opportunity opp = new Opportunity(RecordType = opprt,
                                          Name = 'Teste',
                                          AccountId = a.Id,
                                          StageName = 'Qualificação',
                                          CloseDate = System.today() + 7);
        
        insert(opp);
        
        MessagingChannel mc = [SELECT Id FROM MessagingChannel LIMIT 1];
        
        
        MessagingEndUser meu = [SELECT Id FROM MessagingEndUser WHERE MessagingPlatformKey = 'whatsapp:+554792590057' LIMIT 1];
        
        if(meu == null){
            meu = new MessagingEndUser(Name = 'whatsapp:+554792590058', 
                                           MessagingChannelId = mc.Id, 
                                           MessageType = 'WhatsApp', 
                                           MessagingPlatformKey = 'whatsapp:+554792590058');
            
            insert(meu);
        }
        
        
        MessagingSession ms = new MessagingSession(CaseId = c.Id,
                                                   MessagingChannelId = mc.Id,
                                                   MessagingEndUserId = meu.Id,
                                                   Status = 'Ended');
        
        insert(ms);
        
        
        ContentDocument cd = [SELECT Id FROM ContentDocument LIMIT 1];
        ContentDocumentLink cdl = new ContentDocumentLink(ContentDocumentId = cd.Id,
                                                          LinkedEntityId = ms.Id);
        
        insert(cdl);
        
        ms.CaseId = null;
        ms.OpportunityId = opp.Id;
        
        Database.update(ms);
        
        Database.delete(cdl);
        
		ContentDocumentLink cdlOpp = new ContentDocumentLink(ContentDocumentId = cd.Id,
                                                             LinkedEntityId = ms.Id);        
        insert(cdlOpp);
        
        ms.OpportunityId = null;
        ms.Account__c = a.Id;
        
        Database.update(ms);
        
        ContentDocumentLink cdlAcc = new ContentDocumentLink(ContentDocumentId = cd.Id,
                                                             LinkedEntityId = ms.Id);   
        
        Database.delete(cdlOpp);
        
        insert(cdlAcc);
    }
    
}