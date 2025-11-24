
```
├── 📁 commonWidget
│   ├── 📁 button_animation
│   │   ├── 📄 LoadingButton.dart
│   │   ├── 📄 WidgetUtils.dart
│   │   ├── 📄 button_animation.dart
│   │   ├── 📄 loading_app.dart
│   │   └── 📄 rounded_loading_button.dart
│   ├── 📁 multi_dropdown
│   │   ├── 📁 controllers
│   │   │   ├── 📄 future_controller.dart
│   │   │   └── 📄 multiselect_controller.dart
│   │   ├── 📁 enum
│   │   │   └── 📄 enums.dart
│   │   ├── 📁 models
│   │   │   ├── 📄 decoration.dart
│   │   │   ├── 📄 dropdown_item.dart
│   │   │   └── 📄 network_request.dart
│   │   ├── 📁 widgets
│   │   │   └── 📄 dropdown.dart
│   │   └── 📄 multi_dropdown.dart
│   ├── 📄 app_field.dart
│   ├── 📄 app_text.dart
│   ├── 📄 styled_drop_down.dart
│   ├── 📄 text_input.dart
│   └── 📄 toast_helper.dart
├── 📁 config
│   └── 📄 get_platform.dart
├── 📁 core
│   ├── 📁 database
│   │   ├── 📁 builders
│   │   │   ├── 📄 column_definition.dart
│   │   │   ├── 📄 column_type.dart
│   │   │   └── 📄 table_builder.dart
│   │   ├── 📁 helpers
│   │   │   ├── 📄 backup_manager.dart
│   │   │   ├── 📄 database_backup_helper.dart
│   │   │   ├── 📄 export_helper.dart
│   │   │   ├── 📄 migration_utils.dart
│   │   │   └── 📄 table_utils.dart
│   │   ├── 📁 migrations
│   │   │   ├── 📄 add_national_id_to_users.dart
│   │   │   ├── 📄 admins_table.dart
│   │   │   ├── 📄 categories_table.dart
│   │   │   ├── 📄 inventory_history_table.dart
│   │   │   ├── 📄 inventory_table.dart
│   │   │   ├── 📄 migration.dart
│   │   │   ├── 📄 orders_table.dart
│   │   │   ├── 📄 permissions_table.dart
│   │   │   ├── 📄 products_table.dart
│   │   │   ├── 📄 rename_permission_name_column.dart
│   │   │   ├── 📄 roles_table.dart
│   │   │   └── 📄 users_table.dart
│   │   ├── 📁 remove_columns
│   │   │   └── 📄 remove_avatar_from_users.dart
│   │   ├── 📁 rename_table
│   │   │   └── 📄 rename_users_to_members.dart
│   │   ├── 📁 seeder
│   │   │   ├── 📄 add_default_categories_seeder.dart
│   │   │   ├── 📄 add_default_editor_user_seeder.dart
│   │   │   ├── 📄 categories_seeder.dart
│   │   │   ├── 📄 permissions_seeder.dart
│   │   │   ├── 📄 seeder.dart
│   │   │   ├── 📄 seeder_manager.dart
│   │   │   └── 📄 users_seeder.dart
│   │   ├── 📄 db_helper.dart
│   │   ├── 📄 helper_respons.dart
│   │   ├── 📄 migration_manager.dart
│   │   └── 📄 query_builder.dart
│   ├── 📁 routes
│   │   ├── 📄 app_routes.dart
│   │   ├── 📄 app_routes_fun.dart
│   │   ├── 📄 navigation.dart
│   │   └── 📄 routes.dart
│   └── 📁 utils
│       ├── 📁 ui_extensions
│       │   ├── 📄 System.dart
│       │   ├── 📄 box_extensions.dart
│       │   ├── 📄 color_extensions.dart
│       │   ├── 📄 complete_flutter_extensions.dart
│       │   ├── 📄 extension_dr.dart
│       │   ├── 📄 extensions_init.dart
│       │   ├── 📄 input_decoration_extensions.dart
│       │   ├── 📄 sizing_extensions.dart
│       │   ├── 📄 style_extensions.dart
│       │   ├── 📄 style_extensions_mor.dart
│       │   └── 📄 text_style_extensions.dart
│       ├── 📄 animation_extension.dart
│       ├── 📄 app_colors.dart
│       ├── 📄 app_form_field_extension.dart
│       ├── 📄 app_styles.dart
│       ├── 📄 app_themes.dart
│       ├── 📄 base.dart
│       ├── 📄 bloc_observer.dart
│       ├── 📄 constant.dart
│       ├── 📄 dialog_extension.dart
│       ├── 📄 enums.dart
│       ├── 📄 extensions.dart
│       ├── 📄 field_extensions.dart
│       ├── 📄 flash_helper.dart
│       ├── 📄 input_decoration_extensions.dart
│       ├── 📄 loger.dart
│       ├── 📄 methods_helpers.dart
│       ├── 📄 onboarding_extensions.dart
│       ├── 📄 phoneix copy.dart
│       ├── 📄 phoneix.dart
│       ├── 📄 sheet_extensions.dart
│       ├── 📄 spinkit_indicator.dart
│       ├── 📄 text_extensions.dart
│       ├── 📄 theme_extensions.dart
│       ├── 📄 translation_generator.dart
│       ├── 📄 unfucs copy.dart
│       └── 📄 unfucs.dart
├── 📁 di
│   └── 📄 service_locator.dart
├── 📁 features
│   ├── 📁 auth
│   │   └── 📁 login
│   │       ├── 📁 data
│   │       │   ├── 📁 data_source
│   │       │   │   └── 📄 data_source.dart
│   │       │   ├── 📁 model
│   │       │   │   ├── 📄 model.dart
│   │       │   │   └── 📄 send_data.dart
│   │       │   └── 📁 repository_impl
│   │       │       └── 📄 repository_impl.dart
│   │       ├── 📁 domin
│   │       │   ├── 📁 repositories
│   │       │   │   └── 📄 repository.dart
│   │       │   └── 📁 usecases
│   │       │       └── 📄 usecase.dart
│   │       └── 📁 presentation
│   │           ├── 📁 controller
│   │           │   ├── 📄 controller.dart
│   │           │   └── 📄 state.dart
│   │           └── 📁 pages
│   │               └── 📄 view.dart
│   ├── 📁 layout
│   │   └── 📁 presentation
│   │       ├── 📁 controller
│   │       │   ├── 📄 cubit.dart
│   │       │   └── 📄 state.dart
│   │       └── 📁 pages
│   │           └── 📄 view.dart
│   ├── 📁 splash
│   │   └── 📁 presentation
│   │       ├── 📁 controller
│   │       │   ├── 📄 controller.dart
│   │       │   └── 📄 state.dart
│   │       └── 📁 pages
│   │           └── 📄 view.dart
│   └── 📁 test_data
│       └── 📁 presentation
│           ├── 📁 controller
│           │   ├── 📄 controller.dart
│           │   └── 📄 state.dart
│           └── 📁 pages
│               ├── 📄 admin_model.dart
│               ├── 📄 get_data_user_cubit.dart
│               ├── 📄 user_model.dart
│               └── 📄 view.dart
├── 📁 gen
│   ├── 📄 assets.gen.dart
│   ├── 📄 fonts.gen.dart
│   └── 📄 locale_keys.g.dart
├── 📄 app.dart
├── 📄 app_initializer.dart
├── 📄 cmd.text
└── 📄 main.dart
```

