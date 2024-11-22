codeunit 43154 "Doc. Release"
{
    [IntegrationEvent(false, false)]
    local procedure OnBeforeReopenNext(var Testing: Record "Testing Workflows")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterReopenNext(var Testing: Record "Testing Workflows")
    begin
    end;

    procedure NextReopen(var Testing: Record "Testing Workflows")
    begin
        OnBeforeReopenNext(Testing);
        if Testing.Status = Testing.Status::Created then
            exit;
        Testing.Status := Testing.Status::Created;
        Testing.modify(true);
        OnAfterReopenNext(Testing);

    end;
}
