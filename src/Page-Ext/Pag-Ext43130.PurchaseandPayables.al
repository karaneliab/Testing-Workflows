pageextension 43150 "Purchase and Payables" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Order Nos.")
        {
            field("Testing Workflows Nos."; Rec."Testing Workflows Nos.")
            {
                Caption = 'Testing Workflows Nos.';
                ApplicationArea = All;

            }
        }
    }
}
