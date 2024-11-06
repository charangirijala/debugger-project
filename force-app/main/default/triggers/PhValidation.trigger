trigger PhValidation on Account(before insert) {
  if (Trigger.isBefore && Trigger.isInsert) {
    for (Account ac : Trigger.new) {
      if (ac.Phone == '' || ac.Phone == null) {
        ac.addError('You cannot insert account with phone field empty');
      }
    }
  }
}
