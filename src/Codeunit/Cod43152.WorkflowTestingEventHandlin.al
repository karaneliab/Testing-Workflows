codeunit 43152 "Workflow Testing Event Handlin"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Testing  Approval Mgmt.", 'OnSendTestingWorkflowForApproval', '', false, false)]
    procedure RunWorkflowOnSendTestingWorkflowForApproval(var Testing: Record "Testing Workflows")
    begin
        WorkflowMgmt.HandleEvent(RunWorkflowOnSendTestingWorkflowForApprovalCode, Testing);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Testing  Approval Mgmt.", 'OnCancelTestingWorkflowForApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelTestingWorkflowForApprovalRequest(var Testing: Record "Testing Workflows")
    begin
        WorkflowMgmt.HandleEvent(RunWorkflowOnCancelTestingWorkflowForApprovalRequestCode, Testing);
    end;

    procedure RunWorkflowOnSendTestingWorkflowForApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendTestingWorkflowForApproval'));
    end;

    procedure RunWorkflowOnCancelTestingWorkflowForApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelTestingWorkflowForApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    var
        Testing: Record "Testing Workflows";
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendTestingWorkflowForApprovalCode, Database::"Testing Workflows",
         TestingOnSendWorkflowForApprovalEventDescTxt, 0, false);

        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelTestingWorkflowForApprovalRequestCode, Database::"Testing Workflows",
         TestingOnCancelWorkflowForApprovalRequestEventDescTxt, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    var
        Testing: Record "Testing Workflows";
    begin
        case EventFunctionName of
            RunWorkflowOnCancelTestingWorkflowForApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelTestingWorkflowForApprovalRequestCode, RunWorkflowOnSendTestingWorkflowForApprovalCode);
            RunWorkflowOnSendTestingWorkflowForApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelTestingWorkflowForApprovalRequestCode, RunWorkflowOnSendTestingWorkflowForApprovalCode);

        end;
    end;

    var
        WorkflowMgmt: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        TestingOnCancelWorkflowForApprovalRequestEventDescTxt: Label 'An Approval request for Testing Approval  is cancelled.';
        TestingOnSendWorkflowForApprovalEventDescTxt: Label 'An Approval request for Testing  Approval  is requested.';
}
