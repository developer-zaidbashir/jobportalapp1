class LanguagePopulate{
   String candidatelangUuid;
   String Languagename;
   String Read;
   String Write;
   String Speak;
   String Language;
   String ProficiencyName;
   String ProficiencyId;

   LanguagePopulate({this.candidatelangUuid,this.ProficiencyId,this.Languagename,this.Read,this.Write,this.Speak,this.Language,this.ProficiencyName});


   factory LanguagePopulate.fromJson(Map<String,dynamic>item){
     return LanguagePopulate(
       candidatelangUuid: item["candidatelangUuid"],
         ProficiencyId: item["ProficiencyId"],
       Languagename: item["Languagename"],
       Read: item["Read"],
       Write: item["Write"],
       Speak: item["Speak"],
       Language: item["Language"],
       ProficiencyName: item["ProficiencyName"]
     );
   }
}