abstract class BannersState {}

class BannersInitialState extends BannersState {}


// main banners
class GetMainBannersLoadingEvent extends BannersState {}

class GetMainBannersLoadedEvent extends BannersState {}

class GetMainBannersErrorEvent extends BannersState {}


// college banners
class GetCollegeBannersLoadingEvent extends BannersState {}

class GetCollegeBannersLoadedEvent extends BannersState {}

class GetCollegeBannersErrorEvent extends BannersState {}


// 'public course banners
class GetPublicBannersLoadingEvent extends BannersState {}

class GetPublicBannersLoadedEvent extends BannersState {}

class GetPublicBannersErrorEvent extends BannersState {}

