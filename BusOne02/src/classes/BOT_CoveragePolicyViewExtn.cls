/*
Name : BOT_CoveragePolicyViewExtn
Created Date : 22-Nov-2018
Created By : Harsha BR
*/
public class BOT_CoveragePolicyViewExtn
{   
    ID coveragePolicyId;
    Public String strRichText{get;set;}
    Public String strRichText1{get;set;}
    Public BOT_CoveragePolicyViewExtn(ApexPages.StandardController controller)
    {
     	coveragePolicyId = controller.getId();
        List<BOT_Coverage_Policy__c> lstCoveragePolicy=[SELECT Id,Test__c,Test1__c
                                                        FROM BOT_Coverage_Policy__c
                                                        WHERE ID=:coveragePolicyId
                                                        LIMIT 1];
        strRichText=lstCoveragePolicy[0].Test__c.replace('*','<br>');
        system.debug('***Before strRichText***'+strRichText);
        strRichText=strRichText.replace('>>', '<ul><li>');
        strRichText=strRichText.replace('|', '</li><li>');
        strRichText=strRichText.replace('<<', '</ul></li>');
        system.debug('***After strRichText***'+strRichText);
        
         strRichText1=lstCoveragePolicy[0].Test1__c.replace('*','<br>');
        system.debug('***Before strRichText1***'+strRichText1);
        strRichText1=strRichText1.replace('>>', '<ul><li>');
        strRichText1=strRichText1.replace('|', '</li><li>');
        strRichText1=strRichText1.replace('<<', '</ul></li>');
        system.debug('***After strRichText1***'+strRichText1);     
    }
}