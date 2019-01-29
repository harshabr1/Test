public with sharing class BOT_DrugAccessDashboard_Extn 
{
    public Id accountId {get;set;}
    public List<BOT_Drug_Access__c> lstDrugAccess {get;set;}
    //public List<Formulary_Products_vod__c> lstFormularyProduct {get;set;}
    public Set<String> setMarkets = new Set<String>();
    //public Set<String> setDrugs = new Set<String>();
    public String selectedMarket {get;set;}
    //public Map<String, List<BOT_Drug_Access__c>> dataMap {get;set;}
    //public List<Decimal> drugAccessPercent {get;set;}
    public Boolean renderChart {get;set;}
    //Controller
    public BOT_DrugAccessDashboard_Extn(ApexPages.StandardController controller)
    {
        accountId = controller.getId();
        selectedMarket = 'immunology';
        //renderChart = true;
        lstDrugAccess = [SELECT Id, Name FROM BOT_Drug_Access__c WHERE BOT_Account__c =: accountId ORDER BY Name];
        for(BOT_Drug_Access__c objDrugAccess : lstDrugAccess)
        {
        	setMarkets.add(objDrugAccess.Name);
        }
        
        marketFilterRetrieve();
    }

    public void marketFilterRetrieve()
    {
        if(selectedMarket == '--ALL--' || selectedMarket == Null)
        {
            renderChart = true;
        }
        else
        {
            renderChart = false;
        }
    }

    public List<selectOption> getDynamicList()
    {
        List<selectOption> options = new List<selectOption>();
        if(setMarkets.size()>0 && setMarkets != null)
        {
            for(String c : setMarkets)
        	{
        		options.add(new selectOption(c,c));
        	}
            if(setMarkets.size()>1)
        	{
        		options.add(new selectOption('--ALL--','--ALL--'));
        	}
        }
        return options;
    }
}