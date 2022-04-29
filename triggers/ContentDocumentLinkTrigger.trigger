/* Data: 13/04/2022 
 * Autor: Mayara Barranco da Silva (Everymind) - mayara.silva@everymind.com.br
 * 
 */

trigger ContentDocumentLinkTrigger on ContentDocumentLink (after insert) {
	
    if(Trigger.isAfter && Trigger.isInsert){
    	String linkedEntityId = '' + Trigger.new[0].LinkedEntityId;
    
    	if(linkedEntityId.startsWith('0Mw')){
 			ContentDocumentLinkTH th = new ContentDocumentLinkTH();
            th.addAttachmentInRelatedObj(Trigger.new[0]);
    	}
    }
    
    
    
}