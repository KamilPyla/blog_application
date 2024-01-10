module ActivityLogsHelper
  def navigation_class(source_kind)
    source_kind != @kind ? 'btn btn-outline-info' : 'btn btn-info'
  end

  def action_kind(kind)
    action_kind_map.fetch(kind.to_sym, 'Nierozpoznany obszar')
  end

  def action_kind_map
    {
      login: 'Logowanie',
      event: 'Wydarzenia',
      post: 'Posty',
      user: 'Profil',
      message: 'Wiadomości',
      comment: 'Komentarze',
      reaction: 'Reakcje'
    }
  end
end
