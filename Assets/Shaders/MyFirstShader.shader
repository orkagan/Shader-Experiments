Shader "Custom/MyFirstShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _MyFloat ("My Float", float) = 2.0
        _WibbleFactor ("Wibble Factor", float) = 1
        _WibbleRate ("Wibble Rate", float) = 1
        _ColorA("ColorA", Color)=(1,1,1,1)
        _ColorB("ColorB", Color)=(0,0,0,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        //LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            //#pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct meshData //per-vertex mesh data
            {
                float4 vertex : POSITION; //vertex position
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0; // uv0 diffuse/normal map textures
                //float4 tangent : TANGENT;
                //float4 color : COLOR;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                //UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION; //clip space position
                float3 normal : TEXTCOORD1; //
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _MyFloat;
            float _WibbleFactor;
            float _WibbleRate;
            float4 _ColorA;
            float4 _ColorB;
            
            v2f vert (meshData v)
            {
                v2f o;
                //v.vertex.xyz += v.normal * (cos(_Time.y*5)+1);
                v.vertex.y += sin(_Time.y * _WibbleRate + v.vertex.x) *_WibbleFactor;
                /*float3 num = (v.uv.x,v.uv.y,1);
                v.vertex.xyz *= num;*/
                o.vertex = UnityObjectToClipPos(v.vertex);
                //o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.uv = v.uv;
                o.normal = mul((float3x3) unity_ObjectToWorld, v.normal);
                //UNITY_TRANSFER_FOG(o,o.vertex);
                o.normal = UnityObjectToClipPos(v.normal);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return lerp(_ColorA, _ColorB, i.uv.x);
                //return float4(0,0,1,1);
                //return float4(i.normal.xy,i.normal.z,1);
                //return float4(i.uv,0,1);
                //return _ColorA;

                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                //UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
