codeunit 43151 "Workflow Testing Response Hand"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Testing: Record "Testing Workflows";
        Variant: Variant;
    begin
        Variant := RecRef;
        case
            RecRef.Number of
            Database::"Testing Workflows":
                begin
                    RecRef.SetTable(Testing);
                    Testing.Validate(Status, Testing.Status::Approved);
                    Handled := true;
                    Testing.Modify(true);
                end;
        end;


    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Testing: Record "Testing Workflows";
        ReleaseDoc: Codeunit "Doc. Release";
    begin
        case
            RecRef.Number of
            DATABASE::"Testing Workflows":
                begin
                    Testing.SetView(RecRef.GetView());
                    Handled := true;
                    ReleaseDoc.NextReopen(Testing);
                end;
        end;
    end;
}
