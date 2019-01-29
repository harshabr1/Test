/*
Name         : BOT_PopulateProductFormularyID
Created By   : Harsha BR 
Created Date : 11-AUG-2018
Overview     :This class is written by BusinessOne Technologies Inc.It used to populate the Product Formulary Id on the Benefit Design Line
*/
public class BOT_PopulateProductFormularyID {
    
    /*
    Public static void updateProductformulary(List<Benefit_Design_Line_vod__c> lstBDLines)
    {
        Set<ID> setPlanProductIDs = new set<ID>();
        Set<ID> setFormularyIDs = new set<ID>();
       
        for(Benefit_Design_Line_vod__c objBDL : lstBDLines)
        {
            if(objBDL.BOT_Plan_Product__c!=null)
            {
                setPlanProductIDs.add(objBDL.BOT_Plan_Product__c);      
            }
            
            if(objBDL.Benefit_Design_vod__c!=null)
            {
                setFormularyIDs.add(objBDL.Benefit_Design_vod__c);   
            }   
        }
        
        List<BOT_Product_Formulary_JO__c> lstProductFormularies = [SELECT Id, BOT_Formulary_ID__c, BOT_Plan_Product_ID__c
                                                                   FROM BOT_Product_Formulary_JO__c 
                                                                   WHERE BOT_Formulary_ID__c in : setFormularyIDs AND BOT_Plan_Product_ID__c in : setPlanProductIDs
                                                                   LIMIT 50000];
        
        for(Benefit_Design_Line_vod__c objBDL : lstBDLines)
        {
            for(BOT_Product_Formulary_JO__c objPF : lstProductFormularies)
            {
                if(objBDL.BOT_Plan_Product__c == objPF.BOT_Plan_Product_ID__c && objBDL.Benefit_Design_vod__c == objPF.BOT_Formulary_ID__c)
                {
                    objBDL.BOT_Product_Formulary__c = objPF.id;
                }
            }   
        } 
    }
       */
}