page 50101 "MME IoT C2D Factbox"
{
    PageType = CardPart;
    Editable = false;
    Caption = 'IoT C2D Response';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Caption = 'Message Details';
                field("Time"; mDateTime)
                {
                    ApplicationArea = All;

                }
                field("Status Code"; mStatusCode)
                {
                    ApplicationArea = All;
                }
            }
            group(grpMessage)
            {
                Caption = 'Message';
                field(Message; mMessage)
                {
                    ShowCaption = false;
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }

    var
        mDateTime: DateTime;
        mStatusCode: Integer;
        mMessage: Text;


    procedure UpdateData(statusCode: Integer; message: Text)
    begin
        mDateTime := CreateDateTime(Today(), Time());
        mMessage := message;
        mStatusCode := statusCode;
    end;

    procedure ClearData()
    begin
        Clear(mDateTime);
        Clear(mMessage);
        Clear(mStatusCode);
    end;
}