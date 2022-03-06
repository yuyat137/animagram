module ApplicationHelper
  BASE_TITLE = 'animagram'.freeze

  def full_title(page_title)
    page_title.blank? ? BASE_TITLE : "#{page_title} | #{BASE_TITLE}"
  end

  def default_meta_tags
    {
      title: 'animagram',
      reverse: true,
      charset: 'utf-8',
      description: 'ペットの写真をシェアしたり、動物の写真を見て癒されよう🐈',
      keywords: '動物, ペット, 写真, フォト',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('animagram-square.png') },
        { href: image_url('animagram-square.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
      ],
      og: {
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('logo-ogp.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary',
        site: '@Lilie_psy',
      }
    }
  end
end
