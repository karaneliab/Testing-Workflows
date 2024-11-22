page 43151 "Testing Workflows List"
{
    ApplicationArea = All;
    Caption = 'Testing Workflows List';
    PageType = List;
    SourceTable = "Testing Workflows";
    UsageCategory = Lists;
    CardPageId = "Testing Workflows Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Date Modified"; Rec."Date Modified")
                {
                    ToolTip = 'Specifies the value of the Last  Date field.', Comment = '%';
                }
                field("Aproval Status"; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }
}
