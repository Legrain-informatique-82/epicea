unit IBConst;

interface

resourcestring
  srSamples = 'Exemples';
  SNoEventsRegistered  = 'Vous devez recenser les �v�nements avant de les mettre dans la queue';
  SInvalidDBConnection = 'Le composant n''est pas connect� � une base de donn�es ouverte';
  SInvalidDatabase     = '''''%s'''' n''est pas connect� � une base de donn�es InterBase';
  SInvalidCancellation = 'Vous ne pouvez pas appeler CancelEvents depuis un gestionnaire OnEventAlerterr';
  SInvalidEvent        = 'Ev�nement vide ajout� � la liste d''�v�nements EventAlerter incorrect';
  SInvalidQueueing     = 'Vous ne pouvez appeler QueueEvents depuis un gestionnaire OnEventAlerter';
  SInvalidRegistration = 'Vous ne pouvez appeler Register ou Unregister depuis un gestionnaire OnEventAlerter';  SMaximumEvents       = 'Vous ne pouvez recenser que 15 �v�nements par EventAlerter';

implementation

end.
  
