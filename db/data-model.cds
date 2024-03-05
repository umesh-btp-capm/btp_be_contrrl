namespace btp.c;


//Creating a Assements for students using node.js handlers

using { cuid } from '@sap/cds/common';

entity Assessments:cuid{
    Agenda : String(50)   @mandatory;           //Anotation type validations
    StartDate: Date    @mandatory;
    EndDate:Date @mandatory;
    DueDate:Date @mandatory;
    DaysPlanned:Integer @assert.range: [7,21];

    //In cds views some data not stored in databse, we will retrive the during execution is called "Virtual"
    virtual OverallStatus:String(50);
    virtual OverallCriticality: Integer;            //Color


}



@cds.persistence.skip
entity OUTPUT_DATA {
    key ID      : String(36);
        COLUMN1 : String(255);
        COLUMN2 : String(255);
        COLUMN3 : String(255);
}


//Media
entity MediaFile : cuid {

    @Core.MediaType: mediaType
    content : LargeBinary;           //2GB,30MB 

    @Core.IsMediaType: true
    mediaType: String;               //PDF,ZIP 

    @Core.ContentDisposition.Filename: fileName
    fileName:String;
}
