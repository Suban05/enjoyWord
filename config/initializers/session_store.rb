# frozen_string_literal: true

Rails.application.config.session_store :cookie_store, key: "_enjoy_word",
                                                      expire_after: 1.month
