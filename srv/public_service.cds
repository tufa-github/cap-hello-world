using {daad.messages as model} from './../db/message-model';

service PublicService {

    @requires: 'authenticated-user'
    entity Messages                   as projection on model.Messages excluding {
        createdAt,
        modifiedAt,
        createdBy,
        modifiedBy
    };

    entity Conversations              as projection on model.Conversations excluding {
        createdAt,
        modifiedAt,
        createdBy,
        modifiedBy
    };

    entity Contexts                   as projection on model.Contexts excluding {
        createdAt,
        modifiedAt,
        createdBy,
        modifiedBy
    };

    entity Users                      as projection on model.Users excluding {
        createdAt,
        modifiedAt,
        createdBy,
        modifiedBy
    };

    entity ConversationParticipations as projection on model.ConversationParticipations excluding {
        createdAt,
        modifiedAt,
        createdBy,
        modifiedBy
    };

    entity Topics                     as projection on model.Topics excluding {
        createdAt,
        modifiedAt,
        createdBy,
        modifiedBy
    };

    entity ObjectReferences           as projection on model.ObjectReferences excluding {
        createdAt,
        modifiedAt,
        createdBy,
        modifiedBy
    };

    entity ProcessReferences          as projection on model.ProcessReferences excluding {
        createdAt,
        modifiedAt,
        createdBy,
        modifiedBy
    };

    entity Attachments                as projection on model.Attachments excluding {
        createdAt,
        modifiedAt,
        createdBy,
        modifiedBy
    };

    entity AttachmentProviders        as projection on model.AttachmentProviders excluding {
        createdAt,
        modifiedAt,
        createdBy,
        modifiedBy
    };

    entity UnreadMessages        as projection on model.UnreadMessages excluding {
        createdAt,
        modifiedAt,
        createdBy,
        modifiedBy
    };

}
