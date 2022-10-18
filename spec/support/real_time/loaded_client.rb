# frozen_string_literal: true

RSpec.shared_context 'loaded client' do
  before do
    client.users['U07KECJ77'] = Slack::RealTime::Models::User.new(
      id: 'U07KECJ77',
      team_id: 'T04KB5WQH',
      name: 'aws',
      deleted: true,
      profile: { title: '', real_name: 'AWS Cloud', display_name: 'aws' },
      is_bot: true,
      is_app_user: false,
      updated: 1504224679,
      presence: 'away'
    )
    client.users['U0J1GAHN1'] = Slack::RealTime::Models::User.new(
      id: 'U0J1GAHN1',
      team_id: 'T04KB5WQH',
      name: 'travis-ci',
      deleted: false,
      color: '5a4592',
      presence: 'away',
      real_name: 'travis-ci',
      tz: 'America\/Los_Angeles',
      tz_label: 'Pacific Standard Time',
      profile: {
        title: 'Used for Travis-CI integration tests on https://github.com/dblock/slack-ruby-client.',
        real_name: 'travis-ci',
        bot_id: 'B0J1L75DY',
        team: 'T04KB5WQH'
      }
    )

    client.bots['B0751JU2H'] = Slack::RealTime::Models::Bot.new(
      id: 'B0751JU2H',
      name: 'bot',
      deleted: false,
      updated: 1435864714
    )

    client.public_channels['C0HNTD0CW'] = Slack::RealTime::Models::Channel.new(
      id: 'C0HNTD0CW',
      name: 'chess',
      is_channel: true,
      is_group: false,
      is_im: false,
      is_mpim: false,
      is_private: false,
      created: 1452005790,
      is_archived: false,
      is_general: false,
      unlinked: 0,
      name_normalized: 'chess',
      is_shared: false,
      is_org_shared: false,
      is_pending_ext_shared: false,
      pending_shared: [],
      parent_conversation: nil,
      creator: 'U04KB5WQR',
      is_ext_shared: false,
      shared_team_ids: ['T04KB5WQH'],
      pending_connected_team_ids: [],
      has_pins: false,
      is_member: false,
      previous_names: [],
      priority: 0
    )
    client.public_channels['C0HLE0BBL'] = Slack::RealTime::Models::Channel.new(
      id: 'C0HLE0BBL',
      name: 'gifs',
      is_channel: true,
      is_group: false,
      is_im: false,
      is_mpim: false,
      is_private: false,
      created: 1451913914,
      is_archived: true,
      is_general: false
    )
    client.public_channels['C0JHNAB5H'] = Slack::RealTime::Models::Channel.new(
      id: 'C0JHNAB5H',
      name: 'rubybot-test',
      is_channel: true,
      is_group: false,
      is_private: false,
      members: %w[U0J1GAHN1 U07518DTL]
    )

    client.public_channels['C0BTNJI59'] = Slack::RealTime::Models::Channel.new(
      id: 'C0BTNJI59',
      name: 'recent-priv-chan',
      is_channel: true,
      is_group: false,
      is_private: true,
      members: %w[U0J1GAHN1 U07518DTL]
    )
    client.private_channels['G0K7EV5A7'] = Slack::RealTime::Models::Channel.new(
      id: 'G0K7EV5A7',
      name: 'mpdm-dblock--rubybot--player1-1',
      is_channel: false,
      is_group: true,
      is_im: false,
      is_mpim: true,
      is_private: true,
      is_archived: false,
      members: %w[U04KB5WQR U0J1GAHN1 U07518DTL],
      created: 1453561861,
      creator: 'U04KB5WQR'
    )

    client.ims['D0J1H6QTV'] = Slack::RealTime::Models::Im.new(
      id: 'D0J1H6QTV',
      is_im: true,
      is_archived: false,
      is_open: true,
      user: 'U04KB5WQR',
      created: 1452270861
    )
  end
end
