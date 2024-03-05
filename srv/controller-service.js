const cds = require('@sap/cds');

module.exports = cds.service.impl(srv => {
    //we have differnet types of handlers
    //1.before handler   --Mainly used for VALIDATIONS(create),AUTHENTICATION(read)
    //2.on handler       --DATA Operations
    //3.after handler    --create/update/delete (After post update activity)


    //Getting data from db
    srv.on('READ','OutputData',async (req,next) => {

        //Trigger a Select query on DB Table via Controller
        //Step-1 - Connect to the DB Table
        const {Assessments}=cds.entities('btp.c');

        //Step-2 - Initlize the transaction
        const tx=cds.transaction(req);

        //Select the Data
        const aAssessments= await tx.run(
            SELECT.from(Assessments)
        )
        var aJSONOutput= [];
        aAssessments.forEach(item => {
            aJSONOutput.push({
                'ID':item.ID,
                'COLUMN1':item.Agenda,
                'COLUMN2':item.StartDate,
                'COLUMN3': item.EndDate
            })
        })
        return aJSONOutput;
    })





    //Custom Validation
    srv.before('CREATE', 'Assessments', (req) => {

        if (req.data.StartDate > req.data.EndDate) {
            req.error({
                code: 501,
                message: 'End Date cannot be earlier then start Date',
                target: 'in/EndDate'
            })
        }

        if (req.data.DueDate < req.data.StartDate) {
            req.error({
                code: 501,
                message: 'Due Date cannot be earlier then start Date',
                target: 'in/DueDate'
            })
        }
        
    })



    //Custom handler for Read - After to get the Virtual feild info
    srv.after('READ','Assessments', (data, req) => {
        //Manupulate the Data
        data.forEach(item => {
            //write some logic to caluculate the status for this item
            let status_info= CaluculateStatus(item);
            item.OverallStatus=status_info.OverallStatus;
            item.OverallCriticality=status_info.OverallCriticality;
        });  
    })
})

//This is for Virtual feild
const CaluculateStatus=(data) => {
    if(!data.StartDate || !data.EndDate || !data.DueDate){
        return {"OverallStatus" : "In Preparation","OverallCriticality" :0};
    }else {
        //current date
        let c_date=new Date();                           c_date.setHours(0,0,0,0);
        let c_duedate=new Date(data.DueDate);            c_duedate.setHours(0,0,0,0);

        return (c_duedate < c_date)?    {"OverallStatus" : "Overdue","OverallCriticality" :1} :             //Ternary operator
                                        {"OverallStatus" : "On Track","OverallCriticality" :3}

    }
}