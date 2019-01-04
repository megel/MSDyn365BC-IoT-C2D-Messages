page 50100 "MME IoT C2D Message"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    Caption = 'IoT C2D Message';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group("IoT Hub")
            {
                Caption = 'IoT Hub';
                field(HubUri; mHubUri)
                {
                    Caption = 'Hub URL';
                    ApplicationArea = All;
                    ExtendedDatatype = URL;
                }
                field("Authorization Token"; mAuthorizationToken)
                {
                    Caption = 'SaS Token';
                    Description = 'SharedAccessSignature sr=iot-hub-uri...';
                    ApplicationArea = All;
                    ExtendedDatatype = Masked;
                }
            }

            group("IoT Device")
            {
                Caption = 'IoT Device';
                field("Device Id"; mDeviceId)
                {
                    Caption = 'Device ID';
                    ApplicationArea = All;
                }

                field("Method"; mMethod)
                {
                    Caption = 'Device Method';
                    ApplicationArea = All;
                }
            }

            group("C2D Message")
            {
                Caption = 'C2D Message';

                field("Message"; mMessage)
                {
                    ShowCaption = false;
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
        area(Factboxes)
        {

            part("MME IoT C2D Factbox"; "MME IoT C2D Factbox")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Send C2D Message")
            {
                Caption = 'Send C2D Message';
                Image = SendMail;
                Promoted = true;

                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    content: HttpContent;
                    client: HttpClient;
                    response: HttpResponseMessage;
                    uri: Text;
                    json: text;
                begin
                    CurrPage."MME IoT C2D Factbox".Page.ClearData();
                    uri := StrSubstNo('%1/twins/%2/methods?api-version=2018-06-30', mHubUri, mDeviceId);
                    client.DefaultRequestHeaders().Add('Authorization', mAuthorizationToken);
                    content.WriteFrom(StrSubstNo('{"methodName":"%1","responseTimeoutInSeconds":200,"payload":{"message":"%2"}}', mMethod, mMessage));
                    client.Post(uri, content, response);
                    response.Content().ReadAs(json);
                    CurrPage."MME IoT C2D Factbox".Page.UpdateData(response.HttpStatusCode(), json);
                end;
            }
        }
    }

    var
        mHubUri: Text;
        mAuthorizationToken: Text;
        mMethod: Text;
        mDeviceId: Text;
        mMessage: Text;
}