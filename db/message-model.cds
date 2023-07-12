using { cuid, managed } from '@sap/cds/common';

namespace daad.messages;

entity Conversations : managed, cuid {
    subject          : String(100);
    topic            : Association to one Topics;
    context          : Association to one Contexts;
    processReference : Association to one ProcessReferences;
    objectReference  : Association to one ObjectReferences;
    participations   : Composition of many ConversationParticipations //Warum brauchen wir Property Participations?
                           on participations.conversation = $self; //Können wir hier Property user einlegen (Composition of many Users?)
    messages         : Composition of many Messages
                           on messages.conversation = $self;
}

entity Topics : managed, cuid {
    title         : localized String(250);
    context       : Association to one Contexts;
    conversations : Association to many Conversations
                        on conversations.topic = $self;
}

entity Contexts : managed {
    key TID           : String(4); // PBF / PF
        name          : localized String(100);
        conversations : Association to many Conversations
                            on conversations.context = $self;
}

entity Messages : managed, cuid {
    conversation : Association to one Conversations;
    sender       : Association to one Users;
    subject      : String;
    message      : LargeString;
    sentAt       : DateTime;
    attachments  : Association to many Attachments
                       on attachments.message = $self;
    receiver     : Association to one Users;
    isReaded     : Boolean default false;
}

/*
entity NewMessages : managed, cuid {
    conversation : Association to one Conversations;
    sender       : Association to one Users;
    receiver     : Association to one Users;
    subject      : String;
    newMessage   : Composition of many Messages;
    sentAt       : DateTime;
    attachments  : Association to many Attachments
                       on attachments.message = $self;
    isReaded    : Boolean default false;
}
*/


entity ConversationParticipations : managed, cuid {
    user         : Association to one Users;
    conversation : Association to one Conversations;
    lastViewedAt : DateTime;
}

entity ObjectReferences : managed {
    key identifier        : String(100);
    key type              : String(100);
        title             : localized String(250);
        processReferences : Association to many ProcessReferences
                                on processReferences.objectReference = $self;
        conversations     : Association to many Conversations
                                on conversations.objectReference = $self; // ungelesene nachrichten datenmodel (return zahl) + deployment(mit Daniel)
}

entity ProcessReferences : managed {
    key identifier      : String(100);
    key type            : String(100);
        title           : localized String(250);
        objectReference : Association to one ObjectReferences;
        conversations   : Association to many Conversations
                              on conversations.processReference = $self;
}

entity Users : managed, cuid {
    objectId          : String(100);
    email             : String(100);
    firstName         : String(100) default null;
    lastName          : String(100) default null;
    initials          : String(2) default null; //was bedeuted initials?
    gender            : String(100) default null;
    preferredLanguage : String(2) default null;
    lastSyncedAt      : DateTime default null;
    isInternal        : Boolean default false;
    messages          : Association to many Messages
                            on messages.sender = $self;
    participations    : Association to many ConversationParticipations
                            on participations.user = $self; //Property conversation einlegen (Composition of many Conversations)?
}

entity Attachments : managed, cuid {
    name     : String(100);
    message  : Association to one Messages;
    mimeType : String(100);
    fileUrl  : String(255);
    provider : Association to one AttachmentProviders;
}

entity AttachmentProviders : managed, cuid {
    name          : String(100);
    configuration : LargeString;
}

entity UnreadMessages : managed, cuid {
    conversationParticipation : Association to one ConversationParticipations;
    message                   : Association to one Messages;
    user                      : Association to one Users;
}

extend ConversationParticipations  with {
    unreadMessages : Composition of many UnreadMessages
                         on unreadMessages.conversationParticipation = $self;
}

extend Messages  with {
    unreadMessages : Composition of many UnreadMessages
                         on unreadMessages.message = $self;
}

extend Users  with {
    unreadMessages : Composition of many UnreadMessages
                         on unreadMessages.user = $self;
}

