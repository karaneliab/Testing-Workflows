page 43150 "Testing Workflows Card"
{
    ApplicationArea = All;
    Caption = 'Testing Workflows Card';
    PageType = Card;
    SourceTable = "Testing Workflows";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.', Comment = '%';
                }
                field("Date Modified"; Rec."Date Modified")
                {
                    ToolTip = 'Specifies the value of the Last  Date field.', Comment = '%';
                }
                field("Approval Status"; Rec.Status)
                {
                    Tooltip = 'Specifies the approval status';

                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;

                action(SendApprovalRequest)
                {
                    Caption = 'Send Approval Request';
                    ToolTip = 'Send an approval request with the specified settings.', Comment = '%';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;
                    trigger OnAction()

                    Var
                        ApprovalWorkflow: Codeunit "Testing  Approval Mgmt.";
                        RecRef: RecordRef;
                        Testing: Record "Testing Workflows";
                    begin

                        //       //RecRef.GetTable(Rec);
                        Testing := Rec;
                        if ApprovalWorkflow.CheckWorkflowEnabled(Testing) then
                            ApprovalWorkflow.OnSendTestingWorkflowForApproval(Testing);


                    end;



                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request.';
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = true;
                    trigger OnAction()

                    Var
                        ApprovalWorkflow: Codeunit "Testing  Approval Mgmt.";
                        RecRef: RecordRef;
                        Testing: Record "Testing Workflows";
                    begin
                        RecRef.GetTable(Rec);
                        ApprovalWorkflow.OnCancelTestingWorkflowForApprovalRequest(Testing);



                    end;
                }
            }

        }
        area(Creation)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Approve the requested changes.';
                    Promoted = true;
                    PromotedCategory = New;
                    Visible = OpenApprovalEntriesExistCurrUser;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;
                    PromotedCategory = New;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;
                    PromotedCategory = New;
                    trigger OnAction()

                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistCurrUser;
                    Promoted = true;

                    PromotedCategory = New;


                    trigger OnAction()
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);

                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = All;
                    Caption = 'Approvals';
                    Image = Approvals;
                    ToolTip = 'View approval requests.';
                    Promoted = true;
                    PromotedCategory = New;
                    Visible = HasApprovalEntries;
                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }
        }

    }
    trigger OnAfterGetCurrRecord()
    begin
        OpenApprovalEntriesExistCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        HasApprovalEntries := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId);
    end;

    var
        NoFieldVisible: Boolean;

        OpenApprovalEntriesExistCurrUser, OpenApprovalEntriesExist, CanCancelApprovalForRecord
        , HasApprovalEntries : Boolean;
        ApprovalsMgmt: Codeunit System.Automation."Approvals Mgmt.";
}
