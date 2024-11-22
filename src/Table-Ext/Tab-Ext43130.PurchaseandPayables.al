tableextension 43150 "Purchase and Payables" extends "Purchases & Payables Setup"
{
    fields
    {
        field(431333; "Testing Workflows Nos.";code[20])
        {
            Caption = 'Testing Workflows Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
