-- Xem định nghĩa view
select
  definition
from
  pg_views
where
  viewname = 'user_stats';