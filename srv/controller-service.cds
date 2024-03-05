using btp.c as b from '../db/data-model';


service myControllerService { //@(impl: './controller-service1.js')

    @odata.draft.enabled
    entity Assessments as select from b.Assessments;         
    

    @readonly entity OutputData  as select from b.OUTPUT_DATA;

    entity MediaFile as select from b.MediaFile;
}

annotate myControllerService.Assessments with @(UI: {                           //step-1
    LineItem             : [
        {
            $Type: 'UI.DataField',
            Value: Agenda,
        },
        {
            $Type: 'UI.DataField',
            Value: StartDate,
        },
        {
            $Type: 'UI.DataField',
            Value: EndDate,
        },
        {
            $Type: 'UI.DataField',
            Value: DueDate,
        },
        {
            $Type: 'UI.DataField',
            Value: DaysPlanned,
        },
        {
            $Type      : 'UI.DataField',
            Value      : OverallStatus,
            Criticality: OverallCriticality,
        },
        

    ],
    //feild Group                                                                           //Step-3
    FieldGroup #BasicData: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: Agenda,
            },
            {
                $Type: 'UI.DataField',
                Value: StartDate,
            },
            {
                $Type: 'UI.DataField',
                Value: EndDate,
            },
            {
                $Type: 'UI.DataField',
                Value: DueDate,
            },
            {
                $Type: 'UI.DataField',
                Value: DaysPlanned,
            },
            {
                $Type      : 'UI.DataField',
                Value      : OverallStatus,
                Criticality: OverallCriticality,
            },

        ],

    },
    Facets               : [{                                                              //Step-4
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#BasicData',
        Label : 'Basic Data',
        ID    : 'idBasicData'
    }],
}) {                                                                                       //Step-2
    Agenda        @title: 'Agenda';
    StartDate     @title: 'Start Date';
    EndDate       @title: 'End Date';
    DueDate       @title: 'Due Date';
    DaysPlanned   @title: 'Days Planned';
    OverallStatus @title: 'Overall Status';
   
}
