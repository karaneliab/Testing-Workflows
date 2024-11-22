codeunit 43150 "Testing  Approval Mgmt."

{
    procedure CheckWorkflowEnabled(var Testing: Record "Testing Workflows"): Boolean
    begin
        if not IsWorkflowEnabled(Testing) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsWorkflowEnabled(var Testing: Record "Testing Workflows"): Boolean
    begin
        exit(WorkflowMgmt.CanExecuteWorkflow(Testing, WorkflowEventHandling.RunWorkflowOnSendTestingWorkflowForApprovalCode))
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendTestingWorkflowForApproval(var Testing: Record "Testing Workflows")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelTestingWorkflowForApprovalRequest(var Testing: Record "Testing Workflows")
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var IsHandled: Boolean; var Variant: Variant)
    var
        Testing: Record "Testing Workflows";
    begin
        case RecRef.Number of
            DATABASE::"Testing Workflows":
                begin
                    RecRef.SetTable(Testing);
                    Testing.Validate(Status, Testing.Status::"Approved");
                    IsHandled := true;
                    Testing.Modify(true);
                    Variant := Testing;
                end;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var ApprovalEntryArgument: Record "Approval Entry"; var RecRef: RecordRef; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        Testing: Record "Testing Workflows";
    begin
        if RecRef.Number = Database::"Testing Workflows" then begin
            RecRef.SetTable(Testing);
            ApprovalEntryArgument."Table ID" := RecRef.Number;
            ApprovalEntryArgument."Document No." := Testing."No.";
            ApprovalEntryArgument.Insert();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        Testing: Record "Testing Workflows";
        Recref: RecordRef;
    begin
        Recref.Get(ApprovalEntry."Record ID to Approve");
        case
            Recref.Number of
            DATABASE::"Testing Workflows":
                begin
                    Recref.SetTable(Testing);
                    Testing.Status := Testing.Status::Rejected;
                    Testing.Modify(true);
                end;
        end;

    end;

    var
        WorkflowEventHandling: Codeunit "Workflow Testing Event Handlin";
        WorkflowMgmt: Codeunit "Workflow Management";
        NoWorkflowEnabledErr: Label 'No Approval Workflow for this record type is enabled';

}
