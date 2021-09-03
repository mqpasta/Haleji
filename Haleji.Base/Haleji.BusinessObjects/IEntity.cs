using System;

namespace Haleji.BusinessObjects
{
    public interface IEntity
    {
        long Key { get; }
        void Update(IEntity entity);
    }

    public static class Helper
    {
        public static void Update(Type type,object source, object target)
        {
            var properties = (type).GetProperties();

            foreach (var p in properties)
            {
                p.SetValue(target, p.GetValue(source, null));
            }
        }
    }
}
