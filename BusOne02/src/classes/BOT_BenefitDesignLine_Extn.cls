/*
Name            : BOT_BenefitDesignLine_Extn
Created date    : 28/08/2018
Created by      : Sreenivasulu Adipudi
Description     : This class is written by BusinessOne Technologies Inc. It is an extension for BOT_BenefitDesignLine_View Visualforce page.
*/
public with sharing class BOT_BenefitDesignLine_Extn 
{
    ID benefitDesignID;                                                         //To store the current record ID
    public string selectedMarket {get;set;}                        				//To store user selected maket from dropdown
    public List<Benefit_Design_Line_vod__c> lstBenefitDesignLine {get;set;}     //To store list of benefit design line records
    set<String> setMarkets = new set<String>();                          		//To store uniquee market values
    public Integer setMarketsSize {get;set;}
    
    //Controller
    public BOT_BenefitDesignLine_Extn(ApexPages.StandardController controller)
    {
        benefitDesignID = controller.getId();
        //To get list of benefit design records associated with selected formulary
        lstBenefitDesignLine = [SELECT Id, Product_vod__r.Market_vod__c FROM Benefit_Design_Line_vod__c WHERE Benefit_Design_vod__c =: benefitDesignID 
                                ORDER BY Product_vod__r.Name LIMIT 50000];
        
        if(lstBenefitDesignLine != Null)
        {
            for(Benefit_Design_Line_vod__c objBenefitDesignLine : lstBenefitDesignLine)
            {
                if(objBenefitDesignLine.Product_vod__r.Market_vod__c != Null)
                {
                    //A set collection is used to eliminate repeated market values
                    setMarkets.add(objBenefitDesignLine.Product_vod__r.Market_vod__c);    
                }
            }
            setMarketsSize = setMarkets.size();
			selectedMarket = 'Immunology';
        	//To get list of benefit design records associated with selected formulary
        	marketFilterRetrieve();
        }
    }
    
 	//To get list of benefit design records associated with selected formulary and selected market
    public void marketFilterRetrieve()
    {
        if(selectedMarket == '--ALL--' || selectedMarket == Null)
        {
            //initialRetrieve();    
            lstBenefitDesignLine = [SELECT Id, Product_vod__r.Market_vod__c, Product_vod__r.Name, Status_Source_vod__c, Restrictions_Source_vod__c, Copay_Source_vod__c, Notes_Source_vod__c 
                                FROM Benefit_Design_Line_vod__c 
                                WHERE Benefit_Design_vod__c =: benefitDesignID 
                                ORDER BY Product_vod__r.Name 
                                LIMIT 50000];
        }
        else if(selectedMarket == 'All Company Products')
        {
        	lstBenefitDesignLine = [SELECT Id, Product_vod__r.Market_vod__c, Product_vod__r.Name, Status_Source_vod__c, Restrictions_Source_vod__c, Copay_Source_vod__c, Notes_Source_vod__c 
                                	FROM Benefit_Design_Line_vod__c 
                                	WHERE Benefit_Design_vod__c =: benefitDesignID AND Competitor_vod__c = false
                                	ORDER BY Product_vod__r.Name 
                                	LIMIT 50000];   
        }
        else
        {
            lstBenefitDesignLine = [SELECT Id, Product_vod__r.Market_vod__c, Product_vod__r.Name, Status_Source_vod__c, Restrictions_Source_vod__c, Copay_Source_vod__c, Notes_Source_vod__c 
                                    FROM Benefit_Design_Line_vod__c 
                                    WHERE Benefit_Design_vod__c =: benefitDesignID AND Product_vod__r.Market_vod__c =: selectedMarket
                                    ORDER BY Product_vod__r.Name 
                                    LIMIT 50000];    
        }
    }
    
    //To create dynamic picklist with market values
    public List<selectOption> getDynamicList()
    {
        List<selectOption> options = new List<selectOption>();
        if(setMarketsSize > 0 && setMarkets != null)
        {
            if(setMarketsSize > 1)
            {
                options.add(new selectOption('--ALL--','--ALL--'));
                options.add(new selectOption('All Company Products','All Company Products'));
            }
            for(String m : setMarkets)
            {
                options.add(new selectOption(m,m));
            }
            options.sort();
        }
        return options;
    }    
}