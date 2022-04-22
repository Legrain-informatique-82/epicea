unit IBConst;

interface

resourcestring
  srSamples = 'Exemples';
  SNoEventsRegistered  = 'Vous devez recenser les événements avant de les mettre dans la queue';
  SInvalidDBConnection = 'Le composant n''est pas connecté à une base de données ouverte';
  SInvalidDatabase     = '''''%s'''' n''est pas connecté à une base de données InterBase';
  SInvalidCancellation = 'Vous ne pouvez pas appeler CancelEvents depuis un gestionnaire OnEventAlerterr';
  SInvalidEvent        = 'Evénement vide ajouté à la liste d''événements EventAlerter incorrect';
  SInvalidQueueing     = 'Vous ne pouvez appeler QueueEvents depuis un gestionnaire OnEventAlerter';
  SInvalidRegistration = 'Vous ne pouvez appeler Register ou Unregister depuis un gestionnaire OnEventAlerter';  SMaximumEvents       = 'Vous ne pouvez recenser que 15 événements par EventAlerter';

implementation

end.
  
